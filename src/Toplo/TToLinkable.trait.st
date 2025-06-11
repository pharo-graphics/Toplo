Trait {
	#name : #TToLinkable,
	#category : #'Toplo-Core'
}

{ #category : #'t - linkable' }
TToLinkable >> checkAction: aValuable [
	" link the receiver through a valuable action. 
	Tha valuable take the event, the receiver 
	and the boolean value of checkable receiver
	as arguments."

	^ self newCheckAction: aValuable
]

{ #category : #'t - linkable' }
TToLinkable >> checkAction: aValuable with: linkedObject [ 

	^ self newCheckAction: aValuable with: linkedObject 


]

{ #category : #'t - linkable' }
TToLinkable >> clickAction: aValuable [

	^ self newClickAction: aValuable
]

{ #category : #'t - linkable' }
TToLinkable >> clickAction: aValuable with: anObject [ 

	^ self newClickAction: aValuable with: anObject 
]

{ #category : #'t - linkable' }
TToLinkable >> newCheckAction: aValuable [
	" link the receiver through a valuable action. 
	Tha valuable take the event, the receiver 
	and the boolean value of checkable receiver
	as arguments."

	^ self newCheckAction: aValuable with: self
]

{ #category : #'t - linkable' }
TToLinkable >> newCheckAction: aValuable with: linkedObject [ 

	" link the receiver through a valuable action along with a linked object. 
	Tha valuable take the event, the linked object and
	the boolean value of checkable receiver as arguments."
	^ ToCheckableActionLink new
		  link: self
		  with: linkedObject
		  action: aValuable
]

{ #category : #'t - linkable' }
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

{ #category : #'t - linkable' }
TToLinkable >> newCheckGroupAction: aValuable with: aCheckableGroup [

	^ ToCheckableGroupActionLink new
		  link: self
		  with: aCheckableGroup
		  action: aValuable
]

{ #category : #'t - linkable' }
TToLinkable >> newCheckReader: aReader writer: aWriter [ 
	" link the receiver through a read message and a write message.
	The link is a read and write association.
	the reader message is used for the reading of the boolean value (read acessor).
	The write message is use to update the linked object  "
	^ self newCheckReader: aReader writer: aWriter with: self
]

{ #category : #'t - linkable' }
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

{ #category : #'t - linkable' }
TToLinkable >> newClickAction: aValuable [

	^ self newClickAction: aValuable with: self
]

{ #category : #'t - linkable' }
TToLinkable >> newClickAction: aValuable with: anObject [ 

	^ ToClickableActionLink new
		  link: self
		  with: anObject
		  action: aValuable;
		yourself
]
