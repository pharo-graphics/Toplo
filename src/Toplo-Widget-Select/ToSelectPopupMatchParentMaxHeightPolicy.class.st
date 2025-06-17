Class {
	#name : #ToSelectPopupMatchParentMaxHeightPolicy,
	#superclass : #ToSelectPopupMaxHeightPolicy,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #layout }
ToSelectPopupMatchParentMaxHeightPolicy >> allNodesAreVisibleIn: aWindow [

	| listElement firstNode lastNode firstDataItemIsPresent lastDataItemIsPresent |
	listElement := aWindow manager listElement.
	listElement nodes ifEmpty: [ ^ true ].
	firstNode := listElement nodes first.
	lastNode := listElement nodes last.
	firstDataItemIsPresent := firstNode holder position = 1.
	lastDataItemIsPresent := lastNode holder position
	                         = listElement dataSource size.
	(firstDataItemIsPresent and: [ lastDataItemIsPresent ]) ifFalse: [
		^ false ].
	^ (firstNode isFullyVisibleInParent: listElement) and: [
		  lastNode isFullyVisibleInParent: listElement ]
]

{ #category : #layout }
ToSelectPopupMatchParentMaxHeightPolicy >> nextLayoutStepFor: aWindow from: aLayoutStep [
	" *** notice: the innerElement maxHeght *** must be *** 
		>= innerElement height and consistent with listElement height - padding height
	If not, it can work but with a possible gap with the listElement height - padding height 
	"

	| listElement rbounds lbounds availableHeight maxHeight |
	listElement := aWindow manager listElement.
	" get the current anchor root and list element bounds to compute the available height "
	rbounds := aWindow manager anchorRoot bounds inSpace.
	lbounds := aWindow manager listElement bounds inSpace.
	availableHeight := rbounds height + rbounds position y
	                   - lbounds position y
	                   - aWindow manager anchorRoot padding bottom max:
		                   listElement padding height.
	" max height according to the padding "
	maxHeight := availableHeight - listElement padding height.

	" if all nodes are visible and the available space is > than the window height
	it means that all fit in the window and that there is no scrolling.
	End with a VFitContent "
	((self allNodesAreVisibleIn: aWindow) and: [
		 aWindow measuredHeight < availableHeight ]) ifTrue: [
			listElement innerElement maxHeight: maxHeight.
			^ ToSelectPopupWindowVFitContentStep new ].

	" rerun if the window height is not ready "
	aWindow measuredHeight = availableHeight ifFalse: [
			listElement measuredExtent:
				listElement measuredWidth @ availableHeight.
			aWindow measuredExtent: aWindow measuredWidth @ availableHeight.
			^ aLayoutStep ].

	" ok, set the maxheight the end the layout with the final step "
	listElement innerElement maxHeight: maxHeight.

	^ ToSelectPopupWindowFinalStep new
]
