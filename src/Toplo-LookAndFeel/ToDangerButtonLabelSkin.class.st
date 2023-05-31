Class {
	#name : #ToDangerButtonLabelSkin,
	#superclass : #ToDefaultButtonLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #testing }
ToDangerButtonLabelSkin class >> type [

	^ #dangerHover
]

{ #category : #built }
ToDangerButtonLabelSkin >> builtForeground [

	^ self theme colorError
]

{ #category : #built }
ToDangerButtonLabelSkin >> builtForegroundHover [

	^ self theme colorErrorHover
]

{ #category : #built }
ToDangerButtonLabelSkin >> builtForegroundPressed [

	^ self theme colorError darker
]
