%%
% This function predicts the ultimate load of rectangular CFST columns 
% under axial compression based on the pretrained Artificial Neural Network 
% - Balancing Composite Motion Optimization (ANN-BCMO) model.
%
%%
% Authors: Tien-Thinh Le, Hai-Bang Ly, Binh Thai Pham, Panagiotis G. Asteris
% Email: letienthinh@duytan.edu.vn; tienthinhle.vn@gmail.com
%
%%
% Compatible with Matlab 2016 or higher
%%
clear all
close all
clc
%
%% Prepare the inputs:
H = 150; % Height of cross section (mm)
W = 120; % Width of cross section (mm)
t = 5; % Thickness of steel tube (mm)
L = 1500; % Length of column (mm)
fy = 400; % Yield strength of steel tube (MPa)
fc = 40; % Compressive strength of filled concrete (MPa)
%
%%
X = [H W t L fy fc]; % Input vector in the real space

%% Normalization of data
NormalizationParameters = [60.00	60.00	0.70	60.00	194.00	7.90	105.40
                           500.00	500.00	16.00	4500.00	835.00	164.10	17900.00];
% Input vector in the normalization space:
X_normalized = (X - NormalizationParameters(1, 1:6))./(NormalizationParameters(2, 1:6) - NormalizationParameters(1, 1:6));

%% Evaluating the AI Prediction Model
% Load the pretrained ANN-BCMO model:
load pretrained_ANN_BCMO.mat

% Prediction of Pu:
Pu_predicted_normalized = bestnet(X_normalized');

%% Reverse mode of normalization of output Pu_predicted_normalized
Pu_predicted = (Pu_predicted_normalized).*(NormalizationParameters(2, 7) - NormalizationParameters(1, 7)) + NormalizationParameters(1, 7);

disp(['Predicted ultimate load Pu is: ', num2str(round(Pu_predicted*100)/100), ' kN'])


