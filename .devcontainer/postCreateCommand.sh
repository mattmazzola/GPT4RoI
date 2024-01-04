git config --global safe.directory '*'
git config --global core.editor "code --wait"
git config --global pager.branch false

# Set AZCOPY concurrency to auto
echo "export AZCOPY_CONCURRENCY_VALUE=AUTO" >> ~/.zshrc
echo "export AZCOPY_CONCURRENCY_VALUE=AUTO" >> ~/.bashrc

# Add dotnet to PATH
echo 'export PATH="$PATH:$HOME/.dotnet"' >> ~/.zshrc
echo 'export PATH="$PATH:$HOME/.dotnet"' >> ~/.bashrc

# Activate conda by default
echo "source /home/vscode/miniconda3/bin/activate" >> ~/.zshrc
echo "source /home/vscode/miniconda3/bin/activate" >> ~/.bashrc

# Use gpt4roi environment by default
echo "conda activate gpt4roi" >> ~/.zshrc
echo "conda activate gpt4roi" >> ~/.bashrc

# Activate conda on current shell
source /home/vscode/miniconda3/bin/activate

# Create and activate gpt4roi environment
conda create -y -n gpt4roi python=3.9
conda activate gpt4roi

echo "Installing CUDA..."
# Even though cuda package install cuda-nvcc, it doesn't pin the same version so we explicitly set both
conda install -y -c nvidia cuda=11.7 cuda-nvcc=11.7

export CUDA_HOME=/home/vscode/miniconda3/envs/gpt4roi
echo "export CUDA_HOME=$CUDA_HOME" >> ~/.zshrc
echo "export CUDA_HOME=$CUDA_HOME" >> ~/.bashrc

pip install --upgrade pip
pip install setuptools_scm
pip install --no-cache-dir -e .

# please use conda re-install the torch, pip may loss some runtime lib
conda install -y -c nvidia -c pytorch pytorch-cuda=11.7 pytorch=1.10.0 torchvision=0.11.1 torchaudio=0.10.0

pip install ninja
pip install flash-attn --no-build-isolation

nvcc -V
TORCH_VERSION=$(python -c "import torch;print(torch.__version__)")
echo "Torch version: $TORCH_VERSION"

MMCV_WITH_OPS=1 pip install -e mmcv-1.4.7

echo "postCreateCommand.sh completed!"
