Class {
	#name : #ToAlbumInnerElement,
	#superclass : #BlScrollableElement,
	#traits : 'TAlbInfiniteDecorator',
	#classTraits : 'TAlbInfiniteDecorator classTrait',
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #initialization }
ToAlbumInnerElement >> initialize [ 

	super initialize.
	self matchParent 
]

{ #category : #'t - infinite editor accessing' }
ToAlbumInnerElement >> next [

	^ next
]

{ #category : #'t - infinite editor accessing' }
ToAlbumInnerElement >> next: aDecoratorOrInfinite [

	next := aDecoratorOrInfinite
]
