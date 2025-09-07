Trait {
	#name : #TToElementWithAction,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with action' }
TToElementWithAction >> checkAction: aValuable [
	" link the receiver through a valuable action. 
	The valuable take the event, the receiver (a checkable))
	and the boolean value of receiver
	as optional arguments."

	self newCheckAction: aValuable
]

{ #category : #'t - element with action' }
TToElementWithAction >> clickAction: aValuable [

	self newClickAction: aValuable
]

{ #category : #'t - element with action' }
TToElementWithAction >> ensuredLinkedActions [

	^ self userData
		  at: #linkedActions
		  ifAbsentPut: [ ToActionLinkSet new holder: self; yourself]
]

{ #category : #'t - element with action' }
TToElementWithAction >> groupCheckAction: aValuable [ 
	
	self newGroupCheckAction: aValuable 

]

{ #category : #'t - element with action' }
TToElementWithAction >> linkedActions [

	^ self userData
		  at: #linkedActions
		  ifAbsent: [  ]
]

{ #category : #'t - element with action' }
TToElementWithAction >> linkedActionsDo: aValuable [

	self linkedActions ifNotNil: [ :la | aValuable value: la ]
]

{ #category : #'t - element with action' }
TToElementWithAction >> newCheckAction: aValuable [
	" link the receiver through a valuable action . 
	Tha valuable take the event as optional argument."

	^ (ToCheckableActionLink new action: aValuable)
		  linkWith: self;
		  yourself
]

{ #category : #'t - element with action' }
TToElementWithAction >> newClickAction: aValuable [

	" link the receiver through a valuable action . 
	Tha valuable take the event as optional argument."

	^ ToClickableActionLink new
		  action: aValuable;
		  linkWith: self;
		  yourself
]

{ #category : #'t - element with action' }
TToElementWithAction >> newGroupCheckAction: aValuable [ 

	" link the receiver through a valuable action . 
	Tha valuable take the event as optional argument."
	
	^ (ToCheckableGroupActionLink new action: aValuable)
		  linkWith: self;
		  yourself
]

{ #category : #'t - element with action' }
TToElementWithAction >> registerAction: anActionLink [

	self ensuredLinkedActions add: anActionLink
]

{ #category : #'t - element with action' }
TToElementWithAction >> unregisterAction: anActionLink [

	self linkedActions ifNotNil: [ :la | la remove: anActionLink ]
]
