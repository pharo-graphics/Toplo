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

{ #category : #comparing }
ToElementSelector >> = anObject [ 

	self == anObject ifTrue: [ ^ true ].
	^ self class == anObject class
]

{ #category : #visiting }
ToElementSelector >> accept: aVisitor [

	self subclassResponsibility 
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

{ #category : #testing }
ToElementSelector >> isTypeSelector [

	^ false
]

{ #category : #'logical operator' }
ToElementSelector >> none [

	^ ToNoneSelector new
		  left: self;
		  yourself
]

{ #category : #'logical operator' }
ToElementSelector >> not [

	^ ToNotSelector new
		  left: self;
		  yourself
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
ToElementSelector >> withParent: aSelector satisfying: aLookupSelector [

	^ ToParentSatisfyingSelector new
		  left: self;
		  right: aSelector;
		  lookupSelector: aLookupSelector;
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
