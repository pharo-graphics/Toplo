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

	aToLabel text foreground: aBlPaint.
	
	"Need to notify the text modification"
	aToLabel textChanged.
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> initialState: aToLabel [

]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> onInstalledIn: aToLabel [

	super onInstalledIn: aToLabel.
	self initialState: aToLabel
]

{ #category : #'api - install/uninstall  hook' }
ToAbstractLabelDresser >> textAttributes: aTextAttributeList in: aToLabel [

	aToLabel text attributes: aTextAttributeList.
	
	"Need to notify the text modification"
	aToLabel textChanged.
]
