Class {
	#name : #ToSegmentedButton,
	#superclass : #ToToggleButton,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'t - item' }
ToSegmentedButton >> disabled: aBoolean [

	self parentItemListHolder
		ifNil: [ self presetDisabledWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l disabledItem: self ]
				ifFalse: [ l enabledItem: self ] ].
	super disabled: aBoolean
]

{ #category : #skin }
ToSegmentedButton >> newRawSkin [

	^ ToSegmentedButtonSkin new
]

{ #category : #'adding-removing' }
ToSegmentedButton >> onAddedInItemListHolder: aSegmentedElement [

	aSegmentedElement onAddedSegmentedButton: self
	
]

{ #category : #'adding-removing' }
ToSegmentedButton >> onRemovedFromItemListHolder: aSegmentedElement [

	aSegmentedElement onRemovedSegmentedButton: self
	
]
