Class {
	#name : #ToElementSelector,
	#superclass : #Object,
	#category : #'Toplo-Core-Selectors'
}

{ #category : #'logical operator' }
ToElementSelector >> && aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> + aStyleSelector [

	self
		deprecated: 'Please use && instead.'
		transformWith:
			'`@receiver + `@statements1'
				-> '`@receiver && `@statements1'.	

	^ self && aStyleSelector
]

{ #category : #'logical operator' }
ToElementSelector >> - aStyleSelector [


	self
		deprecated: 'Please use && not instead.'
		transformWith:
			'`@receiver - `@selector'
				-> '`@receiver && ((`@selector) not)'.	
	^ ToAndSelector new
		  left: self;
		  right: (aStyleSelector) not;
		  yourself
]

{ #category : #visiting }
ToElementSelector >> accept: aVisitor [

	self subclassResponsibility 
]

{ #category : #'logical operator' }
ToElementSelector >> and: aStyleSelector [

	self
		deprecated: 'Please use && instead.'
		transformWith:
			'`@receiver and: `@statements1'
				-> '`@receiver && `@statements1'.	
	^ self && aStyleSelector
]

{ #category : #converting }
ToElementSelector >> asActionSelector [ 

	Error signal: 'Can''t convert an abstract selector'
]

{ #category : #converting }
ToElementSelector >> asIdelector [ 

	Error signal: 'Can''t convert an abstract selector'
]

{ #category : #converting }
ToElementSelector >> asStampSelector [ 

	Error signal: 'Can''t convert an abstract selector'
]

{ #category : #converting }
ToElementSelector >> asTypeSelector [ 

	Error signal: 'Can''t convert an abstract selector'
]

{ #category : #'logical operator' }
ToElementSelector >> child: aSelector [ 

	self
		deprecated: 'Please use #withChild: instead.'
		transformWith:
			'`@receiver child: `@arg1'
				-> '`@receiver withChild: `@arg1'.	
	^ self withChild: aSelector
]

{ #category : #'logical operator' }
ToElementSelector >> child: aSelector depth: anInteger [

	self
		deprecated: 'Please use #withChild:atDepth: instead.'
		transformWith:
			'`@receiver child: `@arg1 depth: `@arg2'
				-> '`@receiver withChild: `@arg1 atDepth: `@arg2 '.	
	^ self withChild: aSelector atDepth: anInteger
]

{ #category : #'logical operator' }
ToElementSelector >> not [

	^ ToNotSelector new
		  left: self;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> or: aStyleSelector [

	self
		deprecated: 'Please use || instead.'
		transformWith:
			'`@receiver or: `@statements1'
				-> '`@receiver || `@statements1'.	
	^ self || aStyleSelector
]

{ #category : #'logical operator' }
ToElementSelector >> parent: aSelector [ 

	self
		deprecated: 'Please use #withParent: instead.'
		transformWith:
			'`@receiver parent: `@arg1'
				-> '`@receiver withParent: `@arg1'.	
	^ self withParent: aSelector
]

{ #category : #'logical operator' }
ToElementSelector >> parent: aSelector depth: anInteger [

	self
		deprecated: 'Please use #withParent:atDepth: instead.'
		transformWith:
			'`@receiver parent: `@arg1 depth: `@arg2'
				-> '`@receiver withParent: `@arg1 atDepth: `@arg2 '.	
	^ self withParent: aSelector atDepth: anInteger
]

{ #category : #'logical operator' }
ToElementSelector >> sibling: aSelector [

	self
		deprecated: 'Please use #withSibling: instead.'
		transformWith:
			'`@receiver sibling: `@arg1'
				-> '`@receiver withSibling: `@arg1'.	
	^ self withSibling: aSelector
]

{ #category : #'logical operator' }
ToElementSelector >> withChild: aSelector [ 

	^ ToChildSelector new
		  right: aSelector;
		  left: self;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> withChild: aSelector atDepth: anInteger [

	^ ToChildSelector new
		  right: aSelector;
		  left: self;
		  depth: anInteger;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> withParent: aSelector [

	^ ToParentSelector new
		  left: self;
		  right: aSelector;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> withParent: aSelector atDepth: anInteger [

	^ ToParentSelector new
		  left: self;
		  right: aSelector;
		  depth: anInteger;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> withSibling: aSelector [

	^ ToSiblingSelector new
		  left: self;
		  right: aSelector;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> || aStyleSelector [

	^ ToOrSelector new
		  left: self;
		  right: aStyleSelector;
		  yourself
]
