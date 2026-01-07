Trait {
	#name : #TToRemovableNode,
	#instVars : [
		'removeButton'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - removable node' }
TToRemovableNode >> addRemoveButton [

	removeButton ifNotNil: [ ^ self ].
	removeButton := ToIconicRemoveButton new.
	removeButton clickAction: [
			removeButton fireEvent: ToRemoveButtonClickedEvent new ].
	removeButton constraintsDo: [ :c | c ignoreByLayout ].
	self addChild: removeButton.
	self requestNewSkin
]

{ #category : #'t - removable node' }
TToRemovableNode >> isRemovable [

	^ self item notNil and: [self item isRemovable]
]

{ #category : #'t - removable node' }
TToRemovableNode >> removeButton [

	^ removeButton 
]

{ #category : #'t - removable node' }
TToRemovableNode >> removeButtonDo: aValuable [

	removeButton ifNil: [ ^ self ].
	aValuable value: self removeButton
]

{ #category : #'t - removable node' }
TToRemovableNode >> removeRemoveButton [

	removeButton ifNil: [ ^ self ].
	removeButton removeFromParent.
	removeButton := nil.
	self requestNewSkin
]
