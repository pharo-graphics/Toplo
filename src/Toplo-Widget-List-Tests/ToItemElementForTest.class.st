Class {
	#name : #ToItemElementForTest,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-List-Tests-ItemBar'
}

{ #category : #initialization }
ToItemElementForTest >> initialize [

	super initialize.
	label := ToLabel new.
	self addChild: label.
	self fitContent
]

{ #category : #accessing }
ToItemElementForTest >> text: aText [

	label text: aText
]
