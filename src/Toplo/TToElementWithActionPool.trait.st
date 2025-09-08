Trait {
	#name : #TToElementWithActionPool,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with action' }
TToElementWithActionPool >> actionPool [

	^ self userData
		  at: #actionPool
		  ifAbsent: [  ]
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> actionPoolDo: aValuable [

	self actionPool ifNotNil: [ :la | aValuable value: la ]
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> checkAction: aValuable [
	" link the receiver through a valuable action. 
	The valuable take the event, the receiver (a checkable))
	and the boolean value of receiver
	as optional arguments."

	self newCheckAction: aValuable
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> clickAction: aValuable [

	self newClickAction: aValuable
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> ensuredActionPool [

	^ self userData
		  at: #actionPool
		  ifAbsentPut: [ ToActionPool new holder: self; yourself]
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> groupCheckAction: aValuable [ 
	
	self newGroupCheckAction: aValuable 

]

{ #category : #'t - element with action' }
TToElementWithActionPool >> newCheckAction: aValuable [
	" link the receiver through a valuable action . 
	Tha valuable take the event as optional argument."

	^ (ToCheckableActionLink new action: aValuable)
		  linkWith: self;
		  yourself
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> newClickAction: aValuable [

	" link the receiver through a valuable action . 
	Tha valuable take the event as optional argument."

	^ ToClickableActionLink new
		  action: aValuable;
		  linkWith: self;
		  yourself
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> newGroupCheckAction: aValuable [ 

	" link the receiver through a valuable action . 
	Tha valuable take the event as optional argument."
	
	^ (ToCheckableGroupActionLink new action: aValuable)
		  linkWith: self;
		  yourself
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> registerAction: anActionLink [

	self ensuredActionPool registerActionLink: anActionLink
]

{ #category : #'t - element with action' }
TToElementWithActionPool >> unregisterAction: anActionLink [

	self actionPool ifNotNil: [ :la | la unregisterActionLink: anActionLink ]
]
