Trait {
	#name : #TToRemovableNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - removable node' }
TToRemovableNode >> addRemoveButton [

	self shouldBeImplemented 
]

{ #category : #'t - removable node' }
TToRemovableNode >> isRemovable [

	^ self item isRemovable
]

{ #category : #'t - removable node' }
TToRemovableNode >> removeButton [

	^ self shouldBeImplemented 
]

{ #category : #'t - removable node' }
TToRemovableNode >> removeButtonDo: aValuable [

	self removeButton ifNil: [ ^ self ].
	aValuable value: self removeButton
]

{ #category : #'t - removable node' }
TToRemovableNode >> removeRemoveButton [

	self shouldBeImplemented 
]
