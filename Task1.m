% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
I = imread('Zebra.jpg');
J = histeq(I);
X = histeq(J);
imshowpair(X,J,'montage')
axis off
