function ret = cd1(rbm_w, visible_data)
% <rbm_w> is a matrix of size <number of hidden units> by <number of visible units>
% <visible_data> is a (possibly but not necessarily binary) matrix of size <number of visible units> by <number of data cases>
% The returned value is the gradient approximation produced by CD-1. It's of the same shape as <rbm_w>.
  
  
  visible_state = sample_bernoulli(visible_data);
  
  # calculate hidden state from visible state
  hidden_state    = sample_bernoulli( visible_state_to_hidden_probabilities(rbm_w, visible_state) );
  
  #calculate new visible state from hidden state
  visible_state_1 = sample_bernoulli( hidden_state_to_visible_probabilities(rbm_w, hidden_state) );
  
  #calculate new hidden state probabilities from new visible state
  hidden_state_1  = ( visible_state_to_hidden_probabilities(rbm_w, visible_state_1) );
  
  #calculate goodness gradient for initial state
  d_G_by_rbm_w   = configuration_goodness_gradient(visible_state, hidden_state);
  
  #calculate goodness gradient for new state
  d_G_by_rbm_w_1 = configuration_goodness_gradient(visible_state_1, hidden_state_1);
  
  #calculate contrastive divergence
  ret = (d_G_by_rbm_w - d_G_by_rbm_w_1)';
  
end
