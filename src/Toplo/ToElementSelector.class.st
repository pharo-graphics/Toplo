Class {
	#name : 'ToElementSelector',
	#superclass : 'Object',
	#category : 'Toplo-Core-Selector',
	#package : 'Toplo',
	#tag : 'Core-Selector'
}

{ #category : 'logical operator' }
ToElementSelector >> + aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value asElementSelector;
		  yourself
]

{ #category : 'logical operator' }
ToElementSelector >> - aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector value asElementSelector not;
		  yourself
]

{ #category : 'visiting' }
ToElementSelector >> accept: aVisitor [

	self subclassResponsibility 
]

{ #category : 'logical operator' }
ToElementSelector >> and: aStyleSelector [

	self
		deprecated: 'Please use + instead.'
		transformWith:
			'`@receiver and: `@statements1'
				-> '`@receiver + `@statements1'.	
	^ self + aStyleSelector
]

{ #category : 'converting' }
ToElementSelector >> asElementSelector [ 

	^ self 
]

{ #category : 'logical operator' }
ToElementSelector >> child: aSelector [ 

	self
		deprecated: 'Please use #withChild: instead.'
		transformWith:
			'`@receiver child: `@arg1'
				-> '`@receiver withChild: `@arg1'.	
	^ self withChild: aSelector
]

{ #category : 'logical operator' }
ToElementSelector >> child: aSelector depth: anInteger [

	self
		deprecated: 'Please use #withChild:atDepth: instead.'
		transformWith:
			'`@receiver child: `@arg1 depth: `@arg2'
				-> '`@receiver withChild: `@arg1 atDepth: `@arg2 '.	
	^ self withChild: aSelector atDepth: anInteger
]

{ #category : 'logical operator' }
ToElementSelector >> not [

	^ ToNotSelector new
		  left: self;
		  yourself
]

{ #category : 'logical operator' }
ToElementSelector >> or: aStyleSelector [

	^ ToOrSelector new
		  left: self;
		  right: aStyleSelector value asElementSelector;
		  yourself
]

{ #category : 'logical operator' }
ToElementSelector >> parent: aSelector [ 

	self
		deprecated: 'Please use #withParent: instead.'
		transformWith:
			'`@receiver parent: `@arg1'
				-> '`@receiver withParent: `@arg1'.	
	^ self withParent: aSelector
]

{ #category : 'logical operator' }
ToElementSelector >> parent: aSelector depth: anInteger [

	self
		deprecated: 'Please use #withParent:atDepth: instead.'
		transformWith:
			'`@receiver parent: `@arg1 depth: `@arg2'
				-> '`@receiver withParent: `@arg1 atDepth: `@arg2 '.	
	^ self withParent: aSelector atDepth: anInteger
]

{ #category : 'logical operator' }
ToElementSelector >> sibling: aSelector [

	^ ToSiblingSelector new
		  left: self;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'logical operator' }
ToElementSelector >> withChild: aSelector [ 

	^ ToChildSelector new
		  right: aSelector value asElementSelector;
		  left: self;
		  yourself
]

{ #category : 'logical operator' }
ToElementSelector >> withChild: aSelector atDepth: anInteger [

	^ ToChildSelector new
		  right: aSelector value asElementSelector;
		  left: self;
		  depth: anInteger;
		  yourself
]

{ #category : 'logical operator' }
ToElementSelector >> withParent: aSelector [

	^ ToParentSelector new
		  left: self;
		  right: aSelector value asElementSelector;
		  yourself
]

{ #category : 'logical operator' }
ToElementSelector >> withParent: aSelector atDepth: anInteger [

	^ ToParentSelector new
		  left: self;
		  right: aSelector value asElementSelector;
		  depth: anInteger;
		  yourself
]
