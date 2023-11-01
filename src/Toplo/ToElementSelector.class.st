Class {
	#name : #ToElementSelector,
	#superclass : #Object,
	#category : #'Toplo-Core-Selector'
}

{ #category : #'logical operator' }
ToElementSelector >> + aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value asElementSelector;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> - aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value asElementSelector not;
		  yourself
]

{ #category : #visiting }
ToElementSelector >> accept: aVisitor [

	self subclassResponsibility 
]

{ #category : #'logical operator' }
ToElementSelector >> and: aStyleSelector [

	self
		deprecated: 'Please use + instead.'
		transformWith:
			'`@receiver and: `@statements1'
				-> '`@receiver + `@statements1'.	
	^ self + aStyleSelector
]

{ #category : #converting }
ToElementSelector >> asElementSelector [ 

	^ self 
]

{ #category : #'logical operator' }
ToElementSelector >> child: aSelector [ 

	^ ToChildSelector new
		  right: aSelector value asElementSelector;
		  left: self;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> child: aSelector depth: anInteger [

	^ ToChildSelector new
		  right: aSelector value asElementSelector;
		  left: self;
		  depth: anInteger;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> not [

	^ ToNotSelector new
		  left: self;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> or: aStyleSelector [

	^ ToOrSelector new
		  left: self;
		  right: aStyleSelector value asElementSelector;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> parent: aSelector [

	^ ToParentSelector new
		  left: self;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> parent: aSelector depth: anInteger [

	^ ToParentSelector new
		  left: self;
		  right: aSelector value asElementSelector;
		  depth: anInteger;
		  yourself
]

{ #category : #printing }
ToElementSelector >> printOnStyleSheet: aStream [

	self subclassResponsibility
]

{ #category : #'logical operator' }
ToElementSelector >> sibling: aSelector [

	^ ToSiblingSelector new
		  left: self;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : #'skin rule building' }
ToElementSelector >> style: aBlock [

	^ ToStyleScript new select: self style: aBlock
]
