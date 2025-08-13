Trait {
	#name : #TToLinkable,
	#category : #'Toplo-Core'
}

{ #category : #'t - linkable - private' }
TToLinkable >> addWidgetLink: aLinkAction [

	self widgetLinks add: aLinkAction
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

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkCheckAction: aValuable [
	" link the receiver through a valuable action. 
	The valuable take the event, the receiver (a checkable))
	and the boolean value of receiver
	as optional arguments."

	self addWidgetLink: (self newCheckAction: aValuable)
]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkCheckAction: aValuable with: linkedObject [ 

	self addWidgetLink: (self newCheckAction: aValuable with: linkedObject)


]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> linkClickAction: aValuable [

	self addWidgetLink: (self newClickAction: aValuable)
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

	^ (ToCheckableGroupActionLink new action: aValuable)
		  link: aCheckableGroup withWidget: self;
		  yourself
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newCheckAction: aValuable with: linkedObject [
	" link the receiver through a valuable action along with a linked object. 
	Tha valuable take the event, the linked object and
	the boolean value of checkable receiver as arguments."

	^ (ToCheckableActionLink new action: aValuable)
		  link: linkedObject withWidget: self;
		  yourself
]

{ #category : #'t - linkable - instance creation' }
TToLinkable >> newClickAction: aValuable [

	^ ToClickableActionLink new
		  action: aValuable;
		  onWidget: self;
		  yourself
]

{ #category : #'t - linkable - private' }
TToLinkable >> removeWidgetLink: aWidgetLink [

	self widgetLinks remove: aWidgetLink ifAbsent: [ ]
]

{ #category : #'t - linkable - link/unlink action' }
TToLinkable >> unlinkAllWidgetLinks [

	self widgetLinks copy do: [ :link | link unlink ]
]

{ #category : #'t - linkable - accessing' }
TToLinkable >> widgetLinks [

	^ self userData at: #widgetLinks ifAbsentPut: [ IdentitySet new ]
]
