import os
from PIL import Image
import numpy as np
from skimage.transform import resize
import tensorflow as tf
from tensorflow.keras import layers, models
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
import pandas as pd

def findLargestDim(array): # resize all images to largest dimension in dataset
    largest_0 = 0
    largest_1 = 0

    for arr in array:
        shape = arr.shape
        if (shape[0] > largest_0):
            largest_0 = shape[0]
        if (shape[1] > largest_1):
            largest_1 = shape[1]

    return largest_0, largest_1

folder_path = "" # folder path for infected cell images
output_folder = "" # store resized images

if not os.path.exists(output_folder):
    os.makedirs(output_folder)

file_list = os.listdir(folder_path)
infected = []

for filename in file_list:
    if filename.endswith(".png"):
        file_path = os.path.join(folder_path, filename)

        img = Image.open(file_path)
        img_array = np.array(img)

        target_shape = (394, 394) # findLargestDim(array)
        img_array_resized = resize(img_array, target_shape, anti_aliasing=True)


        infected.append(img_array)
        output_path = os.path.join(output_folder, filename)
        Image.fromarray((img_array_resized * 255).astype(np.uint8)).save(output_path)

image_data = []
for l in infected:
    image_data.append(l)
data_dict = {"image": image_data, "label": [1] * 6412} # label 1 for infected cell images
df = pd.DataFrame(data_dict)

######

folder_path = "" # folder path for infected cell images
output_folder = "" # store resized images

if not os.path.exists(output_folder):
  os.makedirs(output_folder)

file_list = os.listdir(folder_path)
uninfected = []

for filename in file_list:
    if filename.endswith(".png"):
        file_path = os.path.join(folder_path, filename)

        img = Image.open(file_path)
        img_array = np.array(img)

        target_shape = (394, 394) # findLargestDim(array)
        img_array_resized = resize(img_array, target_shape, anti_aliasing=True)

        uninfected.append(img_array)
        output_path = os.path.join(output_folder, filename)
        Image.fromarray((img_array_resized * 255).astype(np.uint8)).save(output_path)

u_image_data = [] # uninfected image data
for l in uninfected:
    u_image_data.append(l)
u_data_dict = {"image": u_image_data, "label": [0] * 6412}
u_df = pd.DataFrame(u_data_dict) # uninfected DataFrame

infected = df
uninfected = u_df
full_df = pd.concat([infected, uninfected], ignore_index=True)
full_df = full_df.sample(frac=1, random_state=42).reset_index(drop=True)
full_df = full_df.reset_index(drop=True)

#############

train_df, test_df = train_test_split(full_df, test_size=0.2, random_state=42)

train_images = np.array(train_df['image'].tolist())
test_images = np.array(test_df['image'].tolist())

model = models.Sequential()

model.add(layers.Conv2D(64, (7, 7), strides=1, activation='relu', input_shape=(394, 394, 3)))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.BatchNormalization())

model.add(layers.Conv2D(64, (7, 7), strides=1, activation='relu'))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.BatchNormalization())
model.add(layers.Dropout(0.25))

model.add(layers.Conv2D(64, (7, 7), strides=1, activation='relu'))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.BatchNormalization())

model.add(layers.Conv2D(128, (7, 7), strides=1, activation='relu'))
model.add(layers.Conv2D(128, (7, 7), strides=1, activation='relu'))
model.add(layers.BatchNormalization())

model.add(layers.Flatten())
model.add(layers.Dropout(0.25))

model.add(layers.Dense(64, activation='relu'))
model.add(layers.BatchNormalization())
model.add(layers.Dense(1, activation='sigmoid'))

model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics=["accuracy", tf.keras.metrics.Recall()])

model.fit(train_images, np.array(train_df['label'].tolist()), epochs=10, validation_split=0.2)

print(model.layers)
print(model.summary())

test_loss, test_acc, test_recall = model.evaluate(test_images, np.array(test_df['label'].tolist()))
print(f'Test accuracy: {test_acc}')
print(f'Test loss: {test_loss}')
print(f'Test recall: {test_recall}')
