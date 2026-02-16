Trait {
	#name : #TToMenuWindowModel,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'t - menu window model' }
TToMenuWindowModel >> closeWindow [

	^ self shouldBeImplemented 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> hasInlineWindow [

	^ self manager hasInlineWindow
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> isTopMenu [

	^ self shouldBeImplemented 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> menuWindow [

	^ self shouldBeImplemented 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> menuWindowDo: aValuable [

	self menuWindow ifNil: [ ^ self ].
	aValuable value: self menuWindow
]
