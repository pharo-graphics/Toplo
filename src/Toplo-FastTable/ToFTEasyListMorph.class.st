"
I'm an easy list used to simplify the creation of lists.
My parent is too powerful, I'm just a simplification of it (and no, I will not go to the psy to deal with that).

 Example: 
=========
ToFTEasyListMorph new
	extent: 300@550;
	elements: Morph methods;
	display: [ :method | method selector ];		
	openInWindow.
	
"
Class {
	#name : #ToFTEasyListMorph,
	#superclass : #ToFTTableElement,
	#category : #'Toplo-FastTable-Easy'
}

{ #category : #accessing }
ToFTEasyListMorph >> data: aSequenceableCollection [
	self dataSource data: aSequenceableCollection
]

{ #category : #accessing }
ToFTEasyListMorph >> display: aBlock [
	self dataSource display: aBlock
]

{ #category : #accessing }
ToFTEasyListMorph >> header: aString [
	self ensureAtLeastOneColumn.
	self columns first id: aString
]

{ #category : #accessing }
ToFTEasyListMorph >> icon: aBlock [
	self dataSource icon: aBlock
]

{ #category : #initialization }
ToFTEasyListMorph >> initialize [
	super initialize.
	self dataSource: ToFTEasyListDataSource new
]

{ #category : #accessing }
ToFTEasyListMorph >> menu: aBlock [
	self dataSource menu: aBlock
]
