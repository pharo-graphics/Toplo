Class {
	#name : #ToStyleSelector,
	#superclass : #Object,
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #'logical operator' }
ToStyleSelector >> + aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> - aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value not;
		  yourself
]

{ #category : #visiting }
ToStyleSelector >> accept: aVisitor [

	self subclassResponsibility 
]

{ #category : #'logical operator' }
ToStyleSelector >> and: aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> child: aSelector level: anInteger [

	^ ToChildSelector new
		  left: aSelector value;
		  right: self;
		  parentLevel: anInteger;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> not [

	^ ToNotSelector new
		  left: self;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> or: aStyleSelector [

	^ ToOrSelector new
		  left: self;
		  right: aStyleSelector value;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> parent: aSelector [

	^ ToChildSelector new
		  left: self;
		  right: aSelector value;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> parent: aSelector level: anInteger [

	^ ToChildSelector new
		  left: self;
		  right: aSelector value;
		  parentLevel: anInteger;
		  yourself
]

{ #category : #'skin rule building' }
ToStyleSelector >> style: aBlock [

	^ ToStyleRule selectedWith: self style: aBlock
]

{ #category : #'skin rule building' }
ToStyleSelector >> when: aLookEventClass style: aBlock [

	^ ToStyleRule selectedWith: self when: aLookEventClass style: aBlock
]
