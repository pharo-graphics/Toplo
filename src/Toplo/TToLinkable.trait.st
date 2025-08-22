Trait {
	#name : #TToLinkable,
	#category : #'Toplo-Core'
}

{ #category : #'t - linkable - private' }
TToLinkable >> addLinkedAction: aLinkAction [

	| storedActions |
	storedActions := self userData
		                 at: #linkedActions
		                 ifAbsentPut: [ IdentitySet new ].
	storedActions add: aLinkAction
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> checkAction: aValuable [
	" link the receiver through a valuable action. 
	The valuable take the event, the receiver (a checkable))
	and the boolean value of receiver
	as optional arguments."

	self newCheckAction: aValuable
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> checkAction: aValuable onGroup: aCheckableGroup [

	self newCheckAction: aValuable onGroup: aCheckableGroup
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> checkAction: aValuable with: linkedObject [ 

	self newCheckAction: aValuable with: linkedObject 


]

{ #category : #'t - linkable - declare action' }
TToLinkable >> clickAction: aValuable [

	self newClickAction: aValuable
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> clickAction: aValuable with: anObject [ 

	self newClickAction: aValuable with: anObject 
]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkCheckAction: aValuable [
	" link the receiver through a valuable action. 
	The valuable take the event, the receiver (a checkable))
	and the boolean value of receiver
	as optional arguments."

	self addLinkedAction: (self newCheckAction: aValuable)
]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkCheckAction: aValuable with: linkedObject [ 

	self addLinkedAction: (self newCheckAction: aValuable with: linkedObject)


]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkClickAction: aValuable [

	self addLinkedAction: (self newClickAction: aValuable)
]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkClickAction: aValuable with: anObject [ 

	self addLinkedAction: (self newClickAction: aValuable with: anObject)
]

{ #category : #'t - linkable - accessing' }
TToLinkable >> linkedActions [

	^ self userData at: #linkedActions ifAbsent: [ #(  ) ]
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newCheckAction: aValuable [
	" link the receiver through a valuable action. 
	Tha valuable take the event, the receiver 
	and the boolean value of checkable receiver
	as arguments."

	^ self newCheckAction: aValuable with: self
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newCheckAction: aValuable onGroup: aCheckableGroup [

	^ ToCheckableGroupActionLink new
		  link: self
		  with: aCheckableGroup
		  action: aValuable
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newCheckAction: aValuable with: linkedObject [ 

	" link the receiver through a valuable action along with a linked object. 
	Tha valuable take the event, the linked object and
	the boolean value of checkable receiver as arguments."
	^ ToCheckableActionLink new
		  link: self
		  with: linkedObject
		  action: aValuable
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newClickAction: aValuable [

	^ self newClickAction: aValuable with: self
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newClickAction: aValuable with: anObject [ 

	^ ToClickableActionLink new
		  link: self
		  with: anObject
		  action: aValuable;
		yourself
]

{ #category : #'t - linkable - private' }
TToLinkable >> removeLinkedAction: aLinkAction [

	| storedActions |
	storedActions := self userData
		                 at: #linkedActions
		                 ifAbsent: [ ^ self ].
	storedActions remove: aLinkAction ifAbsent: [ ]
]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> unlinkAllActions [

	| storedActions |
	storedActions := self userData
		                 at: #linkedActions
		                 ifAbsent: [ ^ self ].
	storedActions copy do: [ :action | action unlink ]
]
