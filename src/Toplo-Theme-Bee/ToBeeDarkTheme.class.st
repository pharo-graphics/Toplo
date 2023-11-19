"
https://ant.design/docs/spec/dark

Dark mode is a theme where all UI elements are darkened.

When to use ?

    Dark mode is recommended when you are in a dark environment as it prevents eye strain.
    Dark mode is great for highlighting important content

        It works similarly to turning off the lights in a movie theater.
"
Class {
	#name : 'ToBeeDarkTheme',
	#superclass : 'ToBeeTheme',
	#category : 'Toplo-Theme-Bee',
	#package : 'Toplo-Theme-Bee'
}

{ #category : 'initialization' }
ToBeeDarkTheme >> defaultStampList [
	" skin managing need a list of unique stamps . "

	^ Array streamContents: [ :str |
		  str nextPutAll: super defaultStampList.
		  str nextPutAll: {
				  (ToStyleStamp name: #'background-color' value: Color black).
				  (ToStyleStamp name: #'color-bg-container' value: (Color fromHexString: '#1b1b1b')).
				  (ToStyleStamp name: #'color-bg-container-disabled' value: (Color white alpha: 0.15)).
				  (ToStyleStamp name: #'color-bg-text-active' value: (Color black alpha: 0.15)).
				  (ToStyleStamp name: #'color-bg-text-hover' value: (Color white alpha: 0.30)).
				  (ToStyleStamp name: #'color-border' value: (Color fromHexString: '#a6a6a6')).
				  (ToStyleStamp name: #'color-border-disabled' value: (Color r: 0.7 g: 0.7 b: 0.7 alpha: 0.5)).
				  (ToStyleStamp name: #'color-error-bg' value: (Color fromHexString: '#2a1215')).
				  (ToStyleStamp name: #'color-image-disabled' value: (Color r: 0.7 g: 0.7 b: 0.7 alpha: 1.0)).
				  (ToStyleStamp name: #'color-text' value: (Color r: 255 g: 255 b: 255)).
				  (ToStyleStamp name: #'color-text-disabled' value: (Color r: 0.7 g: 0.7 b: 0.7 alpha: 0.5)).
				  (ToStyleStamp name: #'color-text-heading' value: (Color r: 255 g: 255 b: 255 alpha: 0.88)).
				  (ToStyleStamp name: #'color-text-secondary' value: (Color white alpha: 0.45)).
 } ]
]

{ #category : 'accessing' }
ToBeeDarkTheme >> name [

	^ #'Bee dark'
]
