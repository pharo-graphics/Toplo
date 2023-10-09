Trait {
	#name : #TToElementWithAssociateWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> associateWindowEventHandler [

	^ self userData at: #associateWindowEventHandler
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> associateWindowEventHandler: anEventHandler [

	anEventHandler ifNil: [
		self userData removeKey: #associateWindowEventHandler ifAbsent: [  ].
		^ self ].
	self userData at: #associateWindowEventHandler put: anEventHandler
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> associateWindowFactory [

	^ self userData at: #associateWindowFactory 
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> associateWindowFactory: aValuable [

	self userData at: #associateWindowFactory put: aValuable
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> associateWithWindow: aWindow [

	aWindow associateElement: self.
	self associateWindowEventHandler: (aWindow defaultAssociateElementEventHandler associateWindow: aWindow; yourself).
	self addEventHandler: self associateWindowEventHandler
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> currentAssociateWindow [

	^ self hasAssociateWindow
		  ifTrue: [ self associateWindowEventHandler associateWindow ]
		  ifFalse: [  ]
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> currentAssociateWindowDo: aValuable [

	^ self hasAssociateWindow
		  ifTrue: [ aValuable value: self associateWindowEventHandler associateWindow ]
		  ifFalse: [  ]
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> dissociateFromWindow [

	self currentAssociateWindow associateElement: nil.
	self removeEventHandler: self associateWindowEventHandler.
	self associateWindowEventHandler: nil
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> hasAssociateWindow [

	^ self userData includesKey: #associateWindowEventHandler 
]

{ #category : #'t - element with associate window' }
TToElementWithAssociateWindow >> newAssociateWindow [

	| window |
	self currentAssociateWindow ifNotNil: [
		Error signal: 'Asking for a associate window building twice' ].
	window := self associateWindowFactory cull: self.
	self associateWithWindow: window.
	^ window
]
