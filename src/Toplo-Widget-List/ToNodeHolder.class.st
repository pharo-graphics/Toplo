Class {
	#name : #ToNodeHolder,
	#superclass : #ToBasicNodeHolder,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder >> bindDataItem: aData [ 

	super bindDataItem: aData.
	self node enabled: self isEnabled.
	self isHidden ifTrue: [ self node height: 0 ]
]

{ #category : #testing }
ToNodeHolder >> isDisabled [

	^ self listElement selectionModel isDisabledIndex: self position
]

{ #category : #testing }
ToNodeHolder >> isEnabled [

	^ self isDisabled not
]

{ #category : #testing }
ToNodeHolder >> isHidden [

	^ self listElement selectionModel isHiddenIndex: self position
]

{ #category : #testing }
ToNodeHolder >> isSelectable [

	^ self isUnselectable not
]

{ #category : #testing }
ToNodeHolder >> isUnselectable [

	^ self listElement selectionModel isUnselectableIndex: self position
]
