Class {
	#name : #ToListSelectionContainer,
	#superclass : #ToOverlayElement,
	#instVars : [
		'beneath',
		'removedChildren'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'private - updating' }
ToListSelectionContainer >> addAllSelectionElements: anArray [

	self addChildren: anArray
]

{ #category : #configuration }
ToListSelectionContainer >> applyConfiguration [

	| e |
	super applyConfiguration.
	e := beneath
		     ifTrue: [ 5 ]
		     ifFalse: [ 15 ].
	self elevation: (BlRelativeElevation elevation: e)
]

{ #category : #accessing }
ToListSelectionContainer >> beneath: aBoolean [

	beneath = aBoolean ifTrue: [ ^ self ].
	beneath := aBoolean.
	self requestConfiguration 
]

{ #category : #'children dispatching' }
ToListSelectionContainer >> dispatchChildAdded: anElement [
	" optimized version "
	self isAttachedToSceneGraph ifFalse: [ ^ self ].
	anElement attachSpace.
	anElement dispatchAddedToSceneGraph
]

{ #category : #'private - updating' }
ToListSelectionContainer >> flushRemovedChildren [
	" do not remove the children now. wait the next layout to avoid flashing effect. 
	selection remove followed selection adding leads to a flashing visual effect 
	whereas adding followed by removing don't.
	See #onLayoutDone "

	removedChildren ifNotEmpty: [
			self removeChildren: removedChildren.
			removedChildren := #(  ) ]
]

{ #category : #initialization }
ToListSelectionContainer >> initialize [

	super initialize.
	beneath := true.
	removedChildren := #(  )
]

{ #category : #'hooks - layout' }
ToListSelectionContainer >> onLayoutDone [

	self flushRemovedChildren.
	super onLayoutDone
]

{ #category : #'private - updating' }
ToListSelectionContainer >> removeAllSelectionElements [
	" do not remove the children now. wait the next layout to avoid flashing effect. 
	selection remove followed selection adding leads to a flashing visual effect 
	whereas adding followed by removing don't.
	See #onLayoutDone "

	removedChildren := removedChildren copyWithAll: self children asArray
]

{ #category : #'children add/remove' }
ToListSelectionContainer >> removeChildren: aListOfElements [
	" optimized version "
	
	aListOfElements ifEmpty: [ ^ self ].
	aListOfElements do: [ :anElement | anElement parent: nil ].
	self children removeAll: aListOfElements.
	self invalidate
]
