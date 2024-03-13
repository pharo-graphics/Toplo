Class {
	#name : #ToNodeHolder,
	#superclass : #ToBasicNodeHolder,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder >> dataItem: aData [ 

	super dataItem: aData.
	self node enabled: self isEnabled.
	self isHidden ifTrue: [ self node height: 0 ]
]

{ #category : #testing }
ToNodeHolder >> isDisabled [

	^ self listElement
		  ifNil: [ true ]
		  ifNotNil: [ :le |
		  le disabledSelectionModel containsIndex: self position ]
]

{ #category : #testing }
ToNodeHolder >> isEnabled [

	^ self isDisabled not
]

{ #category : #testing }
ToNodeHolder >> isHidden [

	^ self listElement
		  ifNil: [ true ]
		  ifNotNil: [ :le |
		  le hiddenSelectionModel containsIndex: self position ]
]

{ #category : #testing }
ToNodeHolder >> isSelectable [

	^ self isUnselectable not
]

{ #category : #testing }
ToNodeHolder >> isSelected [

	^ self listElement
		  ifNil: [ false ]
		  ifNotNil: [ :le | le selectionModel containsIndex: self position ]
]

{ #category : #testing }
ToNodeHolder >> isUnselectable [

	^ self listElement
		  ifNil: [ true ]
		  ifNotNil: [ :le |
		  le unselectableSelectionModel containsIndex: self position ]
]
