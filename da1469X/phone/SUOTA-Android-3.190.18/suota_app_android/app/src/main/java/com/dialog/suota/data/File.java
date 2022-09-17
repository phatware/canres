/*
 *******************************************************************************
 *
 * Copyright (C) 2016-2018 Dialog Semiconductor.
 * This computer program includes Confidential, Proprietary Information
 * of Dialog Semiconductor. All Rights Reserved.
 *
 *******************************************************************************
 */

package com.dialog.suota.data;

import android.content.Context;
import android.os.Environment;
import android.util.Log;

import com.dialog.suota.bluetooth.SpotaManager;
import com.dialog.suota.bluetooth.SuotaManager;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;

public class File {
    private static final String filesDir = Environment.getExternalStorageDirectory().getAbsolutePath() + "/Suota";

    private InputStream inputStream;
    private byte crc;
    private byte[] bytes;

    private byte[][][] blocks;

    private int fileBlockSize = 0;
    private int fileChunkSize = Statics.DEFAULT_FILE_CHUNK_SIZE;
    private int bytesAvailable;
    private int numberOfBlocks = -1;
    private int chunksPerBlockCount;
    private int totalChunkCount;
    private int type;

    private File(InputStream inputStream) throws IOException {
        this.inputStream = inputStream;
        this.bytesAvailable = this.inputStream.available();
    }

    public void setType(int type) throws IOException {
        this.type = type;

        if (type == SuotaManager.TYPE) {
            // Reserve 1 extra byte to the total array for the CRC code
            this.bytes = new byte[this.bytesAvailable + 1];
            this.inputStream.read(this.bytes);
            this.crc = calculateCrc();
            this.bytes[this.bytesAvailable] = this.crc;
        } else {
            this.bytes = new byte[this.bytesAvailable];
            this.inputStream.read(this.bytes);
        }
    }

    public int getFileBlockSize() {
        return this.fileBlockSize;
    }

    public int getNumberOfBytes() {
        return this.bytes.length;
    }

    public void setFileBlockSize(int fileBlockSize, int fileChunkSize) {
        this.fileBlockSize = Math.max(fileBlockSize, fileChunkSize);
        this.fileChunkSize = fileChunkSize;
        if (this.fileBlockSize > bytes.length) {
            this.fileBlockSize = bytes.length;
            if (this.fileChunkSize > this.fileBlockSize)
                this.fileChunkSize = this.fileBlockSize;
        }
        this.chunksPerBlockCount = this.fileBlockSize / this.fileChunkSize + (this.fileBlockSize % this.fileChunkSize != 0 ? 1 : 0);
        this.numberOfBlocks = bytes.length / this.fileBlockSize + (bytes.length % this.fileBlockSize != 0 ? 1 : 0);
        this.initBlocks();
    }

    private void initBlocksSuota() {
        totalChunkCount = 0;
        blocks = new byte[numberOfBlocks][][];
        int byteOffset = 0;
        // Loop through all the bytes and split them into pieces the size of the default chunk size
        for (int i = 0; i < numberOfBlocks; i++) {
            int blockSize = fileBlockSize;
            int numberOfChunksInBlock = chunksPerBlockCount;
            // Check if the last block needs to be smaller
            if (byteOffset + fileBlockSize > bytes.length) {
                blockSize = bytes.length % fileBlockSize;
                numberOfChunksInBlock = blockSize / fileChunkSize + (blockSize % fileChunkSize != 0 ? 1 : 0);
            }
            int chunkNumber = 0;
            blocks[i] = new byte[numberOfChunksInBlock][];
            for (int j = 0; j < blockSize; j += fileChunkSize) {
                // Default chunk size
                int chunkSize = fileChunkSize;
                // Last chunk in block
                if (j + fileChunkSize > blockSize) {
                    chunkSize = blockSize % fileChunkSize;
                }

                //Log.d("chunk", "total bytes: " + bytes.length + ", offset: " + byteOffset + ", block: " + i + ", chunk: " + (chunkNumber + 1) + ", blocksize: " + blockSize + ", chunksize: " + chunkSize);
                byte[] chunk = Arrays.copyOfRange(bytes, byteOffset, byteOffset + chunkSize);
                blocks[i][chunkNumber] = chunk;
                byteOffset += chunkSize;
                chunkNumber++;
                totalChunkCount++;
            }
        }
    }


    private void initBlocksSpota() {
        this.numberOfBlocks = 1;
        this.fileBlockSize = this.bytes.length;
        this.totalChunkCount = bytes.length / fileChunkSize + (bytes.length % fileChunkSize != 0 ? 1 : 0);
        this.blocks = new byte[numberOfBlocks][this.totalChunkCount][];
        int byteOffset = 0;
        int chunkSize = fileChunkSize;
        for (int i = 0; i < this.totalChunkCount; i++) {
            if (byteOffset + fileChunkSize > this.bytes.length) {
                chunkSize = this.bytes.length - byteOffset;
            }
            byte[] chunk = Arrays.copyOfRange(this.bytes, byteOffset, byteOffset + chunkSize);
            blocks[0][i] = chunk;
            byteOffset += fileChunkSize;
        }
    }

    // Create the array of blocks using the given block size.
    private void initBlocks() {
        if (this.type == SuotaManager.TYPE) {
            this.initBlocksSuota();
        } else if (this.type == SpotaManager.TYPE) {
            this.initBlocksSpota();
        }
    }

    public byte[][] getBlock(int index) {
        return blocks[index];
    }

    public void close() {
        if (this.inputStream != null) {
            try {
                this.inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public int getNumberOfBlocks() {
        return this.numberOfBlocks;
    }

    public int getChunksPerBlockCount() {
        return chunksPerBlockCount;
    }

    public int getTotalChunkCount() {
        return this.totalChunkCount;
    }

    private byte calculateCrc() throws IOException {
        byte crc_code = 0;
        for (int i = 0; i < this.bytesAvailable; i++) {
            Byte byteValue = this.bytes[i];
            int intVal = byteValue.intValue();
            crc_code ^= intVal;
        }
        Log.d("crc", String.format("Fimware CRC: %#04x", crc_code & 0xff));
        return crc_code;
    }

    public byte getCrc() {
        return crc;
    }

    public static File getByFileName(String filename) throws IOException {
        // Get the file and store it in fileStream
        InputStream is = new FileInputStream(filesDir + "/" + filename);
        return new File(is);
    }

    public static ArrayList<String> list() {
        java.io.File f = new java.io.File(filesDir);
        java.io.File file[] = f.listFiles();
        if (file == null)
            return null;
        Arrays.sort(file, new Comparator<java.io.File>() {
            @Override
            public int compare(java.io.File lhs, java.io.File rhs) {
                return lhs.getPath().compareToIgnoreCase(rhs.getPath());
            }
        });
        Log.d("Files", "Size: "+ file.length);
        ArrayList<String> names = new ArrayList<>();
        for (int i=0; i < file.length; i++) {
            Log.d("Files", "FileName: " + file[i].getName());
            names.add(file[i].getName());
        }
        return names;
    }

    public static boolean createFileDirectories(Context c) {
        String directoryName = filesDir;
        java.io.File directory;
        directory = new java.io.File(directoryName);
        return directory.exists() || directory.mkdirs();
    }
}
