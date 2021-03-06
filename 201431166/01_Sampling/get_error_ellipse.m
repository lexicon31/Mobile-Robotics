function [ellipse_x, ellipse_y] = get_error_ellipse(mu_hat, sigma_hat, confidence)
rng(201601);
% GET_ERROR_ELLIPSE  Plots the error ellipse for a two dimensional
% gaussian distribution, given the mean, covariance, and the confidence
% level for which the ellipse is to be plotted.
%
% Inputs:
%   mu_hat: 2-by-1 mean vector
%   sigma_hat: 2-by-2 covariance matrix
%   confidence: value in the range (0,1), denoting the confidence level for
%   which the error ellipse is to be plotted
% Outputs:
%   ellipse_x: X coordinates of the error ellipse
%   ellipse_y: Y coordinates of the error ellipse
% 
% This code closely follows the method outlined in
% http://www.visiondummy.com/2014/04/draw-error-ellipse-representing-covariance-matrix/


% TODO: check if mu_hat is a 2-by-1 vector. Print an error message and 
% return if check fails.

arr = size(mu_hat);
if arr(1)~=2 || arr(2)~=1
	error('not apt size');
	return;
end

% TODO: check if covariane is a 2-by-2 matrix, and if it is symmetric, and
% if its determinant is < 0. Print an error message and return if the check 
% fails.

b=size(sigma_hat);
ltr=sigma_hat(1,1)*sigma_hat(2,2);
rtl=sigma_hat(2,1)*sigma_hat(1,2);
det=ltr-rtl;
if not (sigma_hat(1,1)==sigma_hat(2,2) || sigma_hat(2,1)==sigma_hat(1,2) ||  b(1)==2 || b(2)==2 || det>=0)
	error('det<0 or not symmetric');
	return;
end
	

% TODO: compute the eigenvalues and eigenvectors of the ellipse. Store the
% the largest eigenvalue and the smallest eigenvalue in the
% variable lambda_large and lambda_small respectively.

E=eig(sigma_hat);
sz = size(E,1);
E_sort = sort(E);
lambda_small = E_sort(1);
lambda_large = E_sort(sz);

% TODO: Generate 100 uniformly spaced samples in the range 0 to 2*pi (i.e., 
% with a pi/50 increment). You'll have to modify the below line. The below
% line generates a vector of 100 zeros. Instead, generate a vector ranging
% from values 0 to 2*pi (2*pi excluded, since it is the same as 0).

theta = zeros(1,100);
for i=1:100
	theta(1,i) = (i-1)*(pi/50);
end;

% TODO: Determine the value of the mahalanobis distance at the required
% confidence level and store it in the variable mahalanobisThresh. Note use
% chi2inv for the same. Do not 'hard' initialize it to a constant.

mahalanobisThresh = chi2inv(confidence,2);

% TODO: Ensure that the variables lambda_large, lambda_small, theta, and
% mahalanobisThresh are set appropriately.
ellipse_x = mu_hat(1) + sqrt(mahalanobisThresh*lambda_large)*cos(theta);
ellipse_y = mu_hat(2) + sqrt(mahalanobisThresh*lambda_small)*sin(theta);

end
