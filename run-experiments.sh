# Set up datasets

# Coat
mkdir -p data/coat/raw
cd data/coat/raw
wget https://www.cs.cornell.edu/~schnabts/mnar/coat.zip
unzip coat.zip
mv coat/test.ascii coat/train.ascii .
rm -rf coat.zip coat/
cd ../..

# Yahoo
mkdir -p yahoo/raw
cd yahoo/raw
cp ../../../../drive/MyDrive/dataset/ydata-ymusic-rating-study-v1_0-test.txt test.txt
cp ../../../../drive/MyDrive/dataset/ydata-ymusic-rating-study-v1_0-train.txt train.txt

# First, to preprocess the datasets, navigate to the src/ directory and run the command
cd ../../../src
python preprocess_datasets.py -d coat yahoo

# Run real world experiments in section 4 of Saito paper
for data in yahoo coat
  do
  for model in wmf expomf relmf bpr ubpr
  do
    python main.py -m $model -d $data -r 10
  done
done

# Summarize results
python summarize_results.py -d yahoo coat
