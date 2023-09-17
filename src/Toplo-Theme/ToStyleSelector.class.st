Class {
	#name : #ToStyleSelector,
	#superclass : #Object,
	#category : #'Toplo-Theme-StyleSheet'
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

{ #category : #'style rule building' }
ToStyleSelector >> event: anEventClass style: aBlock [

	| styleRule |
	styleRule := ToStyleRule new selector: self.
	styleRule event: anEventClass.
	aBlock value: styleRule.
	^ styleRule
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

{ #category : #'style rule building' }
ToStyleSelector >> style: aBlock [

	| styleRule |
	styleRule := ToStyleRule new selector: self.
	aBlock value: styleRule.
	^ styleRule
]
