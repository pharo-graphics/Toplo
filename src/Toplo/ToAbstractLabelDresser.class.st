Class {
	#name : #ToAbstractLabelDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Label'
}

{ #category : #testing }
ToAbstractLabelDresser class >> isAbstract [ 

	^ self = ToAbstractLabelDresser
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> foreground: aBlPaint in: aToLabel [

	aToLabel foreground: aBlPaint
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> initialState: aToLabel [

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> onInstalledIn: aToLabel [

	super onInstalledIn: aToLabel.
	self initialState: aToLabel
]
