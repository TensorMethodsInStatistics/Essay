addpath('mylib/');
addpath('tensor_toolbox-dev/');
addpath('Images/');
%% remove all RGB from each pixel [Figure 7(c)/8(b)]
camb_logo = double(imread('camblogo3.png'));
img_size = size(camb_logo);

imshow(uint8(camb_logo));
rng(2025);

Omega4 = rand(img_size(1), img_size(2)) < 0.4; % 0.2 for Figure 7 and 0.4 for Figure 8

Omega4 = repmat(Omega4, [1, 1, 3]);

b = zeros(img_size);
b(Omega4) = camb_logo(Omega4);

imshow(uint8(b));

lambda = 1;
c_lambda = 1.01;
gamma = 100;
max_iter = 7000;

% DRTC
logo_recovered = DR_TR2(b, lambda, c_lambda, gamma, Omega4, max_iter);

imshow(uint8(logo_recovered));

%% remove rectangle [Figure 9(b)]

top = 30; % the position of the rectangle in # of pixels from top
left = 30; % the position of the rectangle in # of pixels from left
height = 25; % height of rectangle
width = 40; % width of rectangle

rec_rows = top:(top + height - 1);
rec_cols = left:(left + width - 1);

rec_rows = rec_rows(rec_rows <= img_size(1));
rec_cols = rec_cols(rec_cols <= img_size(2));

Omega5 = true(img_size(1), img_size(2));
Omega5(rec_rows, rec_cols) = false;

Omega5 = repmat(Omega5, [1, 1, 3]);
b = zeros(img_size);
b(Omega5) = camb_logo(Omega5);

imshow(uint8(b));

lambda = 1;
c_lambda = 1.01;
gamma = 13000;
max_iter = 10000;
tolerance = 1e-10;

% DRTC
logo_recovered = DR_TR2(b, lambda, c_lambda, gamma, Omega5, max_iter);

imshow(uint8(logo_recovered));
%imwrite(uint8(logo_recovered), 'logo_rectangle_rec.png');
%% remove all 3 RGB for a pixel (Gauss DRTC) [Figure 10(c)]
lowrank_img = double(imread('Gauss.jpg'));

img_size = size(lowrank_img);

imshow(uint8(lowrank_img));

rng(2025);

Omega7 = rand(img_size(1), img_size(2)) < 0.2;

Omega7 = repmat(Omega7, [1, 1, 3]);

b = zeros(img_size);
b(Omega7) = lowrank_img(Omega7);

imshow(uint8(b));

lambda = 1;
c_lambda = 1.01;
gamma = 1000;
max_iter = 5000;

% DRTC
gauss_recovered = DR_TR2(b, lambda, c_lambda, gamma, Omega7, max_iter);

imshow(uint8(gauss_recovered));
%% SiLRTCnr for Gauss [Figure 10(d)]

T = lowrank_img;

alpha = [1, 1, 1e-3];
alpha = alpha / sum(alpha);

maxIter = 500;
epsilon = 1e-5;

factor = 0.98;
gauss_silrtc = SiLRTCnr(T,Omega7,alpha,factor,maxIter,epsilon);

imshow(uint8(gauss_silrtc));

%% SiLRTCnr (for Camb) [Figure 8(c)]

T = camb_logo;

alpha = [1, 1, 1e-3];
alpha = alpha / sum(alpha);

maxIter = 1000;
epsilon = 1e-5;

factor = 0.95;
camb_silrtc = SiLRTCnr(T,Omega4,alpha,factor,maxIter,epsilon); % ensure Omega4 is set to 40% observed above

imshow(uint8(camb_silrtc));

%% SiLRTCnr (Camb rectangle) [Figure 9(c)]

T = camb_logo;

alpha = [1, 1, 1e-3];
alpha = alpha / sum(alpha);

maxIter = 1000;
epsilon = 1e-5;

factor = 0.99;
cambrec_silrtc = SiLRTCnr(T,Omega5,alpha,factor,maxIter,epsilon);

imshow(uint8(cambrec_silrtc));