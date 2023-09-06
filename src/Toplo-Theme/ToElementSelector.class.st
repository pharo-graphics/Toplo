Class {
	#name : #ToElementSelector,
	#superclass : #Object,
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #visiting }
ToElementSelector >> accept: aVisitor [

	self subclassResponsibility 
]

{ #category : #accessing }
ToElementSelector >> and: aStyleSelector [

	^ ToAndSelector new
		  left: self;
		  right: aStyleSelector;
		  yourself
]

{ #category : #accessing }
ToElementSelector >> parent: aSelector [

	^ ToChildSelector new
		  left: self;
		  right: aSelector;
		  yourself
]

{ #category : #accessing }
ToElementSelector >> parent: aSelector level: anInteger [

	^ ToChildSelector new
		  left: self;
		  right: aSelector;
		  parentLevel: anInteger;
		  yourself
]
