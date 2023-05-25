Class {
	#name : #ToDangerLinkButtonSkin,
	#superclass : #ToLinkButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #accessing }
ToDangerLinkButtonSkin class >> type [

	^ #dangerLink
]

{ #category : #built }
ToDangerLinkButtonSkin >> imageSkinType [

	^ ToDangerButtonImageSkin type
]

{ #category : #built }
ToDangerLinkButtonSkin >> labelSkinType [

	^ ToDangerButtonLabelSkin type
]
