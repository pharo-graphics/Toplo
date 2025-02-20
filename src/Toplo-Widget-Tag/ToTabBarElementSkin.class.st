Class {
	#name : #ToTabBarElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabBarElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e clipChildren: false.
		e border: BlBorder empty.
		e selectionOption elementFactory: [
			ToListPrimarySelectionElement new
				placement:
					(ToActionPlacement new action: [ :selection :evt :aBoundsUpdater |
							 | track pos node nodeBounds trackBounds |
							 " compute the selection element to be over the parent track element "
							 node := selection node.
							 track := e userData at: #'selection-track'.
							 nodeBounds := (node measuredBounds inParent: track parent)
								               inChild: selection parent.
							 trackBounds := (track measuredBounds inParent: track parent)
								                inChild: selection parent.
							 pos := e isHorizontal
								        ifTrue: [
									        nodeBounds position x @ trackBounds position y ]
								        ifFalse: [
									        trackBounds position x @ nodeBounds position y ].
							 selection position: pos ]);
				measurement:
					(ToActionMeasurement new action: [ :spec :selection :evt |
							 | track |
							 track := e userData at: #'selection-track'.
							 e isHorizontal
								 ifTrue: [ spec heightSpec beExact: track height ]
								 ifFalse: [ spec widthSpec beExact: track width ] ]) ] ]
]

{ #category : #'event handling' }
ToTabBarElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |  ]
]
