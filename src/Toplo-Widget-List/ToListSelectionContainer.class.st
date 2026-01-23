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

{ #category : #'private - updating' }
ToListSelectionContainer >> addSelectionElement: aSelectionElement [

	self addChild: aSelectionElement
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

{ #category : #initialization }
ToListSelectionContainer >> initialize [

	super initialize.
	beneath := true.
	removedChildren := #(  )
]

{ #category : #'hooks - layout' }
ToListSelectionContainer >> onLayoutDone [

	removedChildren ifNotEmpty: [
			self removeChildren: removedChildren.
			removedChildren := #(  ) ].
	super onLayoutDone
]

{ #category : #'private - updating' }
ToListSelectionContainer >> removeAllSelectionElements [

	" do not remove the children now. wait the next layout to avoid flashing effect. 
	selection remove followed selection adding leads to a flashing visual effect 
	whereas adding followed by removing don't.
	See #onLayoutDone "
	removedChildren := Array streamContents: [ :stream |
			                   stream
				                   nextPutAll: removedChildren;
				                   nextPutAll: self children ]
]
