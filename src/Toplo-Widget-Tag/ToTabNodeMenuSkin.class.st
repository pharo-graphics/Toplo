Class {
	#name : #ToTabNodeMenuSkin,
	#superclass : #ToMenuSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabNodeMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| tabsElement |
		tabsElement := e parent.
		tabsElement isHorizontal
			ifTrue: [
				e hFitContent.
				e vMatchParent.
				e constraintsDo: [ :c |
					c ignored horizontal alignRight.
					c ignored vertical alignCenter ] ]
			ifFalse: [
				e vFitContent.
				e hMatchParent.
				e constraintsDo: [ :c |
					c ignored horizontal alignCenter.
					c ignored vertical alignBottom ] ].
		tabsElement invisibleNodes
			ifEmpty: [ e visibility: BlVisibility gone ]
			ifNotEmpty: [
				e visibility: BlVisibility visible.
				tabsElement isHorizontal
					ifTrue: [
					tabsElement padding:
						(e parent padding withRight: e measuredWidth) ]
					ifFalse: [
						tabsElement padding:
							(e parent padding withBottom: e measuredHeight) ] ].

		e background: (e valueOfTokenNamed: #'background-color') ]
]
