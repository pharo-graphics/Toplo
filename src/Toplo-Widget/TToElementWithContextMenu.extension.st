Extension { #name : #TToElementWithContextMenu }

{ #category : #'*Toplo-Widget-Circular' }
TToElementWithContextMenu >> useCircularContextMenu [

	self contextMenuManagerFactory: [
			ToContextMenuManager new
				windowClass: ToCircularContextMenu;
				placement: ToCircularMenuPickedPlacement new;
				yourself ]
]
