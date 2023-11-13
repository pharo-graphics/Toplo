Class {
	#name : 'ToRadioButton',
	#superclass : 'ToCheckbox',
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : '*Toplo-Theme-Bee' }
ToRadioButton >> defaultBeeStyleStamps [

	^ { #button. #checkable. #radio}
]

{ #category : 'skin' }
ToRadioButton >> iconGeometry [

	^ BlCircleGeometry new
]
