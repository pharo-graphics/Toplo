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

{ #category : #accessing }
ToNodeHolder >> isDisabled [

	^ self listElement
		  ifNil: [ true ]
		  ifNotNil: [ :le |
		  le disabledSelectionModel containsIndex: self position ]
]

{ #category : #accessing }
ToNodeHolder >> isEnabled [

	^ self isDisabled not
]

{ #category : #accessing }
ToNodeHolder >> isHidden [

	^ self listElement
		  ifNil: [ true ]
		  ifNotNil: [ :le |
		  le hiddenSelectionModel containsIndex: self position ]
]

{ #category : #accessing }
ToNodeHolder >> isSelectable [

	^ self isUnselectable not
]

{ #category : #accessing }
ToNodeHolder >> isSelected [

	^ self listElement
		  ifNil: [ false ]
		  ifNotNil: [ :le | le selectionModel containsIndex: self position ]
]

{ #category : #accessing }
ToNodeHolder >> isUnselectable [

	^ self listElement
		  ifNil: [ true ]
		  ifNotNil: [ :le |
		  le unselectableSelectionModel containsIndex: self position ]
]
