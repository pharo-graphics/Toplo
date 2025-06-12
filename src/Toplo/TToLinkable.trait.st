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
TToLinkable >> checkAction: aValuable with: linkedObject [ 

	self newCheckAction: aValuable with: linkedObject 


]

{ #category : #'t - linkable - declare action' }
TToLinkable >> checkFeature: aFeatureName with: aLinkedObject [
	" link the receiver through a message and a message receiver.
	The link is a read and write association.
	aFeatureName is a receiver feature used for the reading of the boolean value (read acessor).
	The write accessor is computed from the read accessor (with #asMutator) "

	self newCheckFeature: aFeatureName with: aLinkedObject
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> checkGroupAction: aValuable with: aCheckableGroup [

	self newCheckGroupAction: aValuable with: aCheckableGroup
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> checkReader: aReader writer: aWriter [ 
	" link the receiver through a read message and a write message.
	The link is a read and write association.
	the reader message is used for the reading of the boolean value (read acessor).
	The write message is use to update the linked object  "
	self newCheckReader: aReader writer: aWriter 
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> checkReader: aReader writer: aWriter with: aLinkedObject [
	" link the receiver through a read message and a write message.
	The link is a read and write association.
	the reader message is used for the reading of the boolean value (read acessor).
	The write message is use to update the linked object  "

	self newCheckReader: aReader writer: aWriter with: aLinkedObject
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
TToLinkable >> linkCheckFeature: aFeatureName with: aLinkedObject [
	" link the receiver through a message and a message receiver.
	The link is a read and write association.
	aFeatureName is a receiver feature used for the reading of the boolean value (read acessor).
	The write accessor is computed from the read accessor (with #asMutator) "

	self addLinkedAction: (self newCheckFeature: aFeatureName with: aLinkedObject)
]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkCheckReader: aReader writer: aWriter [ 
	" link the receiver through a read message and a write message.
	The link is a read and write association.
	the reader message is used for the reading of the boolean value (read acessor).
	The write message is use to update the linked object  "
	self addLinkedAction: (self newCheckReader: aReader writer: aWriter)
]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkCheckReader: aReader writer: aWriter with: aLinkedObject [
	" link the receiver through a read message and a write message.
	The link is a read and write association.
	the reader message is used for the reading of the boolean value (read acessor).
	The write message is use to update the linked object  "

	self addLinkedAction: (self newCheckReader: aReader writer: aWriter with: aLinkedObject)
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
TToLinkable >> newCheckFeature: aFeatureName with: aLinkedObject [
	" link the receiver through a message and a message receiver.
	The link is a read and write association.
	aFeatureName is a receiver feature used for the reading of the boolean value (read acessor).
	The write accessor is computed from the read accessor (with #asMutator) "

	^ ToCheckableLink new
		  link: self
		  with: aLinkedObject
		  reader: aFeatureName asSymbol
		  writer: aFeatureName asSymbol asMutator
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newCheckGroupAction: aValuable with: aCheckableGroup [

	^ ToCheckableGroupActionLink new
		  link: self
		  with: aCheckableGroup
		  action: aValuable
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newCheckReader: aReader writer: aWriter [ 
	" link the receiver through a read message and a write message.
	The link is a read and write association.
	the reader message is used for the reading of the boolean value (read acessor).
	The write message is use to update the linked object  "
	^ self newCheckReader: aReader writer: aWriter with: self
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newCheckReader: aReader writer: aWriter with: aLinkedObject [
	" link the receiver through a read message and a write message.
	The link is a read and write association.
	the reader message is used for the reading of the boolean value (read acessor).
	The write message is use to update the linked object  "

	^ ToCheckableLink new
		  link: self
		  with: aLinkedObject
		  reader: aReader
		  writer: aWriter
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
