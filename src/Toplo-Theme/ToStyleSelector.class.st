Class {
	#name : #ToStyleSelector,
	#superclass : #Object,
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #'logical operator' }
ToStyleSelector >> + aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value asStyleSelector;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> - aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value asStyleSelector not;
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
ToStyleSelector >> asStyleSelector [ 

	^ self 
]

{ #category : #'logical operator' }
ToStyleSelector >> child: aSelector [ 

	^ ToChildSelector new
		  right: aSelector value asStyleSelector;
		  left: self;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> child: aSelector depth: anInteger [

	^ ToChildSelector new
		  right: aSelector value asStyleSelector;
		  left: self;
		  depth: anInteger;
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
		  right: aStyleSelector value asStyleSelector;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> parent: aSelector [

	^ ToParentSelector new
		  left: self;
		  right: aSelector value asStyleSelector;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> parent: aSelector depth: anInteger [

	^ ToParentSelector new
		  left: self;
		  right: aSelector value asStyleSelector;
		  depth: anInteger;
		  yourself
]

{ #category : #'logical operator' }
ToStyleSelector >> sibling: aSelector [

	^ ToSiblingSelector new
		  left: self;
		  right: aSelector value asStyleSelector;
		  yourself
]

{ #category : #'skin rule building' }
ToStyleSelector >> style: aBlock [

	^ ToStyleRule selectedWith: self style: aBlock
]
