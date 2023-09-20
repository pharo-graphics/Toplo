Class {
	#name : #ToStyleSelector,
	#superclass : #Object,
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #'logical operator' }
ToStyleSelector >> + aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value asToTag;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> - aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value asToTag not;
		  yourself
]

{ #category : #visiting }
ToStyleSelector >> accept: aVisitor [

	self subclassResponsibility 
]

{ #category : #'logical operator' }
ToStyleSelector >> and: aStyleSelector [

	self
		deprecated: 'Please use + instead.'
		transformWith:
			'`@receiver and: `@statements1'
				-> '`@receiver + `@statements1'.	
	^ self + aStyleSelector
]

{ #category : #converting }
ToStyleSelector >> asToTag [ 

	^ self 
]

{ #category : #'logical operator' }
ToStyleSelector >> child: aSelector level: anInteger [

	^ ToChildSelector new
		  left: aSelector value asToTag;
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
		  right: aStyleSelector value asToTag;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> parent: aSelector [

	^ ToChildSelector new
		  left: self;
		  right: aSelector value asToTag;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> parent: aSelector level: anInteger [

	^ ToChildSelector new
		  left: self;
		  right: aSelector value asToTag;
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
