#!/bin/bash

#SBATCH -J Samtools
#SBATCH -p general
#SBATCH -o Sort_CREB1_cJun_%j.txt
#SBATCH -e Sort_CREB1_cJun_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=xuexiao@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=120:00:00
#SBATCH --mem=100G

module unload python
module load python
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate velocyto

################################### Sort bam files ################################################

cd /N/slate/xuexiao/cJun_ChIP/Align
samtools sort Ctrol_H3K9_S1_bowtie2.bam -o Ctrol_H3K9_S1_bowtie2_sorted.bam
samtools sort OV3_H3K9_S2_bowtie2.bam -o OV3_H3K9_S2_bowtie2_sorted.bam
samtools sort OV3_IgG_S3_bowtie2.bam -o OV3_IgG_S3_bowtie2_sorted.bam
samtools sort OV3_cJun_S4_bowtie2.bam -o OV3_cJun_S4_bowtie2_sorted.bam
samtools sort OV3_CREB_S5_bowtie2.bam -o OV3_CREB_S5_bowtie2_sorted.bam
samtools sort OV3_Input_S6_bowtie2.bam -o OV3_Input_S6_bowtie2_sorted.bam

#################################### Generate Bigwig files ################################################

cd /N/slate/xuexiao/cJun_ChIP/Align

samtools index Ctrol_H3K9_S1_bowtie2_sorted.bam
samtools index OV3_H3K9_S2_bowtie2_sorted.bam
samtools index OV3_IgG_S3_bowtie2_sorted.bam
samtools index OV3_cJun_S4_bowtie2_sorted.bam
samtools index OV3_CREB_S5_bowtie2_sorted.bam
samtools index OV3_Input_S6_bowtie2_sorted.bam

cd /N/slate/xuexiao/cJun_ChIP/peaks

bamCoverage --bam /N/slate/xuexiao/cJun_ChIP/Align/Ctrol_H3K9_S1_bowtie2_sorted.bam -o Ctrol_H3K9_S1_bowtie2_sorted.SeqDepthNorm.bw --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2913022398 --extendReads --outFileFormat bigwig

bamCoverage --bam /N/slate/xuexiao/cJun_ChIP/Align/OV3_H3K9_S2_bowtie2_sorted.bam -o OV3_H3K9_S2_bowtie2_sorted.SeqDepthNorm.bw --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2913022398 --extendReads --outFileFormat bigwig

bamCoverage --bam /N/slate/xuexiao/cJun_ChIP/Align/OV3_IgG_S3_bowtie2_sorted.bam -o OV3_IgG_S3_bowtie2_sorted.SeqDepthNorm.bw --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2913022398 --extendReads --outFileFormat bigwig

bamCoverage --bam /N/slate/xuexiao/cJun_ChIP/Align/OV3_cJun_S4_bowtie2_sorted.bam -o OV3_cJun_S4_bowtie2_sorted.SeqDepthNorm.bw --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2913022398 --extendReads --outFileFormat bigwig

bamCoverage --bam /N/slate/xuexiao/cJun_ChIP/Align/OV3_CREB_S5_bowtie2_sorted.bam -o OV3_CREB_S5_bowtie2_sorted.SeqDepthNorm.bw --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2913022398 --extendReads --outFileFormat bigwig

bamCoverage --bam /N/slate/xuexiao/cJun_ChIP/Align/OV3_Input_S6_bowtie2_sorted.bam -o OV3_Input_S6_bowtie2_sorted.SeqDepthNorm.bw --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2913022398 --extendReads --outFileFormat bigwig

source deactivate
