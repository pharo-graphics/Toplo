Class {
	#name : #ToSkinDemoTheme,
	#superclass : #ToRawTheme,
	#category : #'Toplo-Demo-Skin Demo - 3'
}

{ #category : #accessing }
ToSkinDemoTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , {
		  (ToTokenProperty
			   name: #'background-clicked'
			   value: Color lightGreen).
		  (ToTokenProperty
			   name: #'background-not-clicked'
			   value: Color lightRed).
		  (ToTokenProperty
			   name: #'background-clicked-hovered'
			   value: Color lightGreen darker).
		  (ToTokenProperty
			   name: #'background-not-clicked-hovered'
			   value: Color lightRed darker) }
]

{ #category : #'skin creation' }
ToSkinDemoTheme >> newSkinFor: anElement [ 

	^ anElement newSkinDemoSkin 
]
