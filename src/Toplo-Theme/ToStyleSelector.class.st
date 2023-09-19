Class {
	#name : #ToStyleSelector,
	#superclass : #Object,
	#category : #'Toplo-Theme-StyleSelector'
}

{ #category : #visiting }
ToStyleSelector >> accept: aVisitor [

	self subclassResponsibility 
]

{ #category : #accessing }
ToStyleSelector >> and: aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector;
		  yourself
]

{ #category : #accessing }
ToStyleSelector >> child: aSelector level: anInteger [

	^ ToChildSelector new
		  left: aSelector;
		  right: self;
		  parentLevel: anInteger;
		  yourself
]

{ #category : #accessing }
ToStyleSelector >> not [

	^ ToNotSelector new
		  left: self;
		  yourself
]

{ #category : #accessing }
ToStyleSelector >> or: aStyleSelector [

	^ ToOrSelector new
		  left: self;
		  right: aStyleSelector;
		  yourself
]

{ #category : #accessing }
ToStyleSelector >> parent: aSelector [

	^ ToChildSelector new
		  left: self;
		  right: aSelector;
		  yourself
]

{ #category : #accessing }
ToStyleSelector >> parent: aSelector level: anInteger [

	^ ToChildSelector new
		  left: self;
		  right: aSelector;
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
