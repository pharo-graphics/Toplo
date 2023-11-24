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

{ #category : 'accessing' }
ToBeeDarkTheme class >> defaultReadOnlyStampList [
	" skin managing need a list of unique stamps . "

	^ Array streamContents: [ :str |
		  str nextPutAll: super defaultReadOnlyStampList.
		  str nextPutAll: {
				  (ToReadOnlyStyleStamp name: #'background-color' value: Color black).
				  (ToReadOnlyStyleStamp name: #'color-bg-container' value: (Color fromHexString: '#1b1b1b')).
				  (ToReadOnlyStyleStamp name: #'color-bg-container-disabled' value: (Color white alpha: 0.15)).
				  (ToReadOnlyStyleStamp name: #'color-bg-text-active' value: (Color black alpha: 0.15)).
				  (ToReadOnlyStyleStamp name: #'color-bg-text-hover' value: (Color white alpha: 0.30)).
				  (ToReadOnlyStyleStamp name: #'color-border' value: (Color fromHexString: '#a6a6a6')).
				  (ToReadOnlyStyleStamp name: #'color-border-disabled' value: (Color r: 0.7 g: 0.7 b: 0.7 alpha: 0.5)).
				  (ToReadOnlyStyleStamp name: #'color-error-bg' value: (Color fromHexString: '#2a1215')).
				  (ToReadOnlyStyleStamp name: #'color-image-disabled' value: (Color r: 0.7 g: 0.7 b: 0.7 alpha: 1.0)).
				  (ToReadOnlyStyleStamp name: #'color-text' value: (Color r: 255 g: 255 b: 255)).
				  (ToReadOnlyStyleStamp name: #'color-text-disabled' value: (Color r: 0.7 g: 0.7 b: 0.7 alpha: 0.5)).
				  (ToReadOnlyStyleStamp name: #'color-text-heading' value: (Color r: 255 g: 255 b: 255 alpha: 0.88)).
				  (ToReadOnlyStyleStamp name: #'color-text-secondary' value: (Color white alpha: 0.45)).
 } ]
]

{ #category : 'accessing' }
ToBeeDarkTheme >> name [

	^ #'Bee dark'
]
