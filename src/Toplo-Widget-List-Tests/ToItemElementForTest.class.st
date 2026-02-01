Class {
	#name : #ToItemElementForTest,
	#superclass : #ToElement,
	#traits : 'TToListItem',
	#classTraits : 'TToListItem classTrait',
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #configuration }
ToItemElementForTest >> applyConfiguration [ 

	super applyConfiguration.
	self applyConfigurationAsListItem
]

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
