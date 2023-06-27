Class {
	#name : #ToDangerPrimaryButtonSkin,
	#superclass : #ToPrimaryButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #accessing }
ToDangerPrimaryButtonSkin class >> type [

	^ #dangerPrimary
]

{ #category : #built }
ToDangerPrimaryButtonSkin >> builtBackground [

	^ self theme colorError
]

{ #category : #built }
ToDangerPrimaryButtonSkin >> builtBackgroundHover [ 

	^ self theme colorErrorHover
]

{ #category : #built }
ToDangerPrimaryButtonSkin >> builtBackgroundPressed [ 

	^ self theme colorError darker
]
