Class {
	#name : #ToDangerHoverLabelSkin,
	#superclass : #ToDefaultHoverLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #testing }
ToDangerHoverLabelSkin class >> type [

	^ #dangerHover
]

{ #category : #built }
ToDangerHoverLabelSkin >> builtForeground [

	^ self theme colorError
]

{ #category : #built }
ToDangerHoverLabelSkin >> builtForegroundHover [

	^ self theme colorErrorHover
]
