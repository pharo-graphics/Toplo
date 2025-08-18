Trait {
	#name : #TToLinkable,
	#category : #'Toplo-Core'
}

{ #category : #'t - linkable - declare action' }
TToLinkable >> checkAction: aValuable [
	" link the receiver through a valuable action. 
	The valuable take the event, the receiver (a checkable))
	and the boolean value of receiver
	as optional arguments."

	self newCheckAction: aValuable
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> clickAction: aValuable [

	self newClickAction: aValuable
]

{ #category : #'t - linkable - declare action' }
TToLinkable >> groupCheckAction: aValuable [ 
	
	self newGroupCheckAction: aValuable 

]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newCheckAction: aValuable [
	" link the receiver through a valuable action along with a linked object. 
	Tha valuable take the event, the linked object and
	the boolean value of checkable receiver as arguments."

	^ (ToCheckableActionLink new action: aValuable)
		  onWidget: self;
		  yourself
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newClickAction: aValuable [

	^ ToClickableActionLink new
		  action: aValuable;
		  onWidget: self;
		  yourself
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newGroupCheckAction: aValuable [ 

	^ (ToCheckableGroupActionLink new action: aValuable)
		  onWidget: self;
		  yourself
]
